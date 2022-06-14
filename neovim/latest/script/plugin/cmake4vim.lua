-- ===========================
-- -------- cmake4vim --------
-- ===========================

return {
    'ilyachur/cmake4vim',
    config = function()
        vim.g.cmake_build_dir = 'build'
        vim.g.cmake_build_type = 'Debug'
        vim.g.cmake_compile_commands = 1
    end,
}
