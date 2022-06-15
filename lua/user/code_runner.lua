local cmp_status_ok, cr = pcall(require, "code_runner")
if not cmp_status_ok then
	return
end

cr.setup({
	filetype = {
		java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
		python = "python3 -u",
		typescript = "deno run",
		rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
	},
})
