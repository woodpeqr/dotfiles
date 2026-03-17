local telescope = require("telescope")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local neotest = require("neotest")

local M = {}

--- @class PickerCommands
--- @field [string] fun(...):any

--- @class PickerOpts
--- @field prompt_title? string
--- @field initial_mode? string 'normal' or 'insert'
--- @field close_on_action? boolean
--- @field opts? table opts for telescope

--- @param commands PickerCommands
--- @param opts PickerOpts
--- @return fun(): any
M.create_picker = function(commands, opts)
    local t_opts = vim.tbl_deep_extend('force', require("telescope.themes").get_dropdown(), opts.opts or {})
    return function()
        pickers.new(t_opts, {
            prompt_title = opts.prompt_title,
            initial_mode = opts.initial_mode,
            finder = finders.new_table({
                results = vim.tbl_keys(commands)
            }),
            sorter = conf.generic_sorter(t_opts),
            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    local selection = action_state.get_selected_entry()[1]
                    if opts.close_on_action == nil or opts.close_on_action == true then
                        actions.close(prompt_bufnr)
                    end
                    if commands[selection] then
                        commands[selection]()
                    end
                end)
                return true
            end
        }):find()
    end
end

return M
