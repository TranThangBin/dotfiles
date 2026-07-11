local dir = require("nvim.dir")

local set = vim.keymap.set

local fileperm = tonumber("0644", 8) or 420
local dirperm = tonumber("0755", 8) or 493

local function _refresh_dir()
    if vim.api.nvim_get_mode().mode ~= "n" then
        vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "n", false)
    end

    dir._reload()
end

local function get_seletected_filepaths(root_dirpath, buf)
    --- @type integer
    local start = vim.fn.getpos("v")[2]

    --- @type integer
    local finish = vim.fn.getcurpos()[2]

    if start > finish then
        start, finish = finish, start
    end

    return vim.tbl_map(function(filename)
        return vim.fs.joinpath(root_dirpath, filename)
    end, vim.api.nvim_buf_get_lines(buf, start - 1, finish, false))
end

--- @param filepaths string[]
--- @param idx number
--- @param all boolean
--- @param delete_lst { path: string, rm_opts:vim.fs.rm.Opts }[]
--- @return void
local function delete_files(filepaths, idx, all, delete_lst)
    if idx > #filepaths then
        for _, delete_item in pairs(delete_lst) do
            vim.fs.rm(delete_item.path, delete_item.rm_opts)
        end

        _refresh_dir()
        return
    end

    local filepath = filepaths[idx]
    local filename = vim.fs.basename(filepath)

    if filepath == nil then
        return
    end

    local input_opts = {
        prompt = ("Confirm deletion of file <%s> [{y(es)},n(o),a(ll)]: "):format(
            filename
        ),
    }
    local rm_opts = { recursive = false }

    local filestat = vim.uv.fs_stat(filepath)

    if filestat ~= nil and filestat.type == "directory" then
        input_opts.prompt = ("Confirm *recursive* deletion of directory <%s> [{y(es)},n(o),a(ll)]: "):format(
            filename
        )
        rm_opts.recursive = true
    end

    local delete_item = { path = filepath, rm_opts = rm_opts }

    if all then
        table.insert(delete_lst, delete_item)
        delete_files(filepaths, idx + 1, all, delete_lst)
        return
    end

    vim.ui.input(input_opts, function(opt)
        if opt == "y" or opt == "a" then
            table.insert(delete_lst, delete_item)
        end

        if opt == "y" or opt == "n" then
            delete_files(filepaths, idx + 1, all, delete_lst)
        elseif opt == "a" then
            delete_files(filepaths, idx + 1, true, delete_lst)
        end
    end)
end

--- @param prompt fun(filepath: string): string
--- @param filepaths string[]
--- @param idx number
--- @param new_filepaths string[]
--- @param handle fun(new_filepaths: string[])
--- @return void
local function _collect_filepaths(prompt, filepaths, idx, new_filepaths, handle)
    if idx > #filepaths then
        handle(new_filepaths)
        _refresh_dir()
        return
    end

    local filepath = filepaths[idx]

    if filepath == nil then
        return
    end

    vim.ui.input({
        prompt = prompt(filepath),
        default = filepath,
    }, function(new_filepath)
        if new_filepath == nil or new_filepath == "" then
            return
        end

        new_filepaths[idx] = new_filepath

        _collect_filepaths(prompt, filepaths, idx + 1, new_filepaths, handle)
    end)
end

--- @param filepaths string[]
--- @return void
local function move_files(filepaths)
    _collect_filepaths(
        function(filepath)
            return ("Moving %s to : "):format(filepath)
        end,
        filepaths,
        1,
        {},
        function(new_filepaths)
            for i, filepath in pairs(filepaths) do
                local new_filepath = new_filepaths[i]

                if
                    new_filepath ~= nil
                    and filepath ~= ""
                    and filepath ~= new_filepath
                then
                    vim.uv.fs_rename(filepath, new_filepath)
                end
            end
        end
    )
end

local function _copy_file(src, dst)
    local filestat = vim.uv.fs_stat(src)

    if filestat == nil then
        return
    end

    if filestat.type ~= "directory" then
        vim.uv.fs_copyfile(src, dst)
        return
    end

    vim.uv.fs_mkdir(dst, dirperm)

    local handle = vim.uv.fs_scandir(src)
    while handle do
        local filename, filetype = vim.uv.fs_scandir_next(handle)

        if filename == nil then
            break
        end

        local src_path = vim.fs.joinpath(src, filename)
        local dst_path = vim.fs.joinpath(dst, filename)

        if filetype ~= "directory" then
            vim.uv.fs_copyfile(src_path, dst_path)
        else
            _copy_file(src_path, dst_path)
        end
    end
end

--- @param filepaths string[]
--- @return void
local function copy_files(filepaths)
    _collect_filepaths(
        function(filepath)
            return ("Copying %s to : "):format(filepath)
        end,
        filepaths,
        1,
        {},
        function(new_filepaths)
            for i, filepath in pairs(filepaths) do
                local new_filepath = new_filepaths[i]

                if
                    new_filepath ~= nil
                    and filepath ~= ""
                    and filepath ~= new_filepath
                then
                    _copy_file(filepath, new_filepath)
                end
            end
        end
    )
end

set("n", "<leader>e", function()
    local filepath = vim.fn.expand("%")

    if type(filepath) ~= "string" then
        return
    end

    local filedir = vim.fs.dirname(filepath)
    local filename = vim.fs.basename(filepath)

    vim.cmd.edit(filedir)
    vim.api.nvim_feedkeys(vim.keycode("<Plug>(nvim-dir-reload)"), "n", false)
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

                local fd = vim.uv.fs_open(filepath, "w", fileperm)

                if fd == nil then
                    return
                end

                vim.uv.fs_close(fd)
                vim.api.nvim_feedkeys(
                    vim.keycode(
                        ("<Plug>(nvim-dir-reload):edit %s<CR>"):format(
                            vim.fn.fnameescape(filepath)
                        )
                    ),
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
            delete_files(
                get_seletected_filepaths(root_dirpath, e.buf),
                1,
                false,
                {}
            )
        end, {
            buf = e.buf,
            desc = "Custom(directory): [D]elete file(s)",
            nowait = true,
        })

        set({ "n", "x" }, "mv", function()
            move_files(get_seletected_filepaths(root_dirpath, e.buf))
        end, {
            buf = e.buf,
            desc = "Custom(directory): [m]o[v]ing file(s)",
            nowait = true,
        })

        set({ "n", "x" }, "cp", function()
            copy_files(get_seletected_filepaths(root_dirpath, e.buf))
        end, {
            buf = e.buf,
            desc = "Custom(directory): [c]o[p]ying file(s)",
            nowait = true,
        })
    end,
})
