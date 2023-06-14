local cmake_status_ok, cmake = pcall(require, "cmake-tools")
if not cmake_status_ok then
  return
end

cmake.setup {
    cmake_kits_path = "C:\\Users\\Kakule\\AppData\\Local\\CMakeTools\\cmake-tools-kits.json"
}
