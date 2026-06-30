local set = vim.keymap.set

local function delete_files(root_dirpath, filenames, idx, all, on_complete)
    if idx > #filenames then
        on_complete()
        return
    end

    local filename = filenames[idx]

    local input_opts = {
        prompt = string.format(
            "Confirm deletion of file <%s> [{y(es)},n(o),a(ll)]: ",
            filename
        ),
    }
    local rm_opts = { recursive = false }

    local filepath = vim.fs.joinpath(root_dirpath, filename)
    local filestat = vim.uv.fs_stat(filepath)

    if filestat ~= nil and filestat.type == "directory" then
        input_opts.prompt = string.format(
            "Confirm *recursive* deletion of directory <%s> [{y(es)},n(o),a(ll)]: ",
            filename
        )
        rm_opts.recursive = true
    end

    if all then
        vim.fs.rm(filepath, rm_opts)
        delete_files(root_dirpath, filenames, idx + 1, all, on_complete)
        return
    end

    vim.ui.input(input_opts, function(opt)
        if opt == "y" or opt == "a" then
            vim.fs.rm(filepath, rm_opts)
        end

        if opt == "y" then
            delete_files(root_dirpath, filenames, idx + 1, all, on_complete)
        elseif opt == "a" then
            delete_files(root_dirpath, filenames, idx + 1, true, on_complete)
        end
    end)
end

set("n", "<leader>e", function()
    local filepath = vim.fn.expand("%")

    if type(filepath) ~= "string" then
        return
    end

    local filedir = vim.fs.dirname(filepath)
    local filename = vim.fs.basename(filepath)

    vim.cmd.edit(filedir)
    vim.cmd.normal("R")
    vim.fn.search(filename)
end, { desc = "Custom: [e]dit" })

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("custom/directory", { clear = true }),
    pattern = "directory",
    desc = "Custom: Directory",
    callback = function(e)
        local root_dirpath = e.file

        set("n", "%", function()
            vim.ui.input({
                prompt = "Enter filename: ",
            }, function(filename)
                if filename == nil or filename == "" then
                    return
                end

                local filepath = vim.fs.joinpath(root_dirpath, filename)
                local fileperm = tonumber("0644", 8)

                if fileperm == nil then
                    return
                end

                local fd = vim.uv.fs_open(filepath, "w", fileperm)

                if fd == nil then
                    return
                end

                vim.uv.fs_close(fd)
                vim.api.nvim_feedkeys(
                    vim.keycode("<Plug>(nvim-dir-reload)"),
                    "n",
                    false
                )
            end)
        end, {
            buf = e.buf,
            desc = "Custom(directory): Create file",
            nowait = true,
        })

        set("n", "d", function()
            vim.ui.input({
                prompt = "Please give directory name: ",
            }, function(dirname)
                if dirname == nil or dirname == "" then
                    return
                end

                local dirpath = vim.fs.joinpath(root_dirpath, dirname)
                local dirperm = tonumber("0755", 8)

                if dirperm == nil then
                    return
                end

                vim.uv.fs_mkdir(dirpath, dirperm)
                vim.api.nvim_feedkeys(
                    vim.keycode("<Plug>(nvim-dir-reload)"),
                    "n",
                    false
                )
            end)
        end, {
            buf = e.buf,
            desc = "Custom(directory): Make [d]irectory",
            nowait = true,
        })

        set({ "n", "x" }, "D", function()
            local start = vim.fn.getpos("v")[2]
            local finish = vim.fn.getcurpos()[2]

            if start > finish then
                start, finish = finish, start
            end

            local filenames =
                vim.api.nvim_buf_get_lines(e.buf, start - 1, finish, false)

            delete_files(root_dirpath, filenames, 1, false, function()
                if vim.api.nvim_get_mode().mode ~= "n" then
                    vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "n", false)
                end

                vim.api.nvim_feedkeys(
                    vim.keycode("<Plug>(nvim-dir-reload)"),
                    "n",
                    false
                )
            end)
        end, {
            buf = e.buf,
            desc = "Custom(directory): [D]elete file(s)",
            nowait = true,
        })
    end,
})
