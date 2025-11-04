local status_ok, project = pcall(require, "project")
if not status_ok then
  return
end

local tele_status_ok, telescope = pcall(require, "telescope")
if not tele_status_ok then
  return
end

telescope.load_extension("projects")
