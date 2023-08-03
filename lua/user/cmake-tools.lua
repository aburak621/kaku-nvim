local cmake_status_ok, cmake = pcall(require, "cmake-tools")
if not cmake_status_ok then
  return
end

cmake.setup {
    cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1", "-G Ninja" },
    cmake_build_directory = "build"
    -- cmake_kits_path = "C:\\Users\\Kakule\\AppData\\Local\\CMakeTools\\cmake-tools-kits.json"
}
