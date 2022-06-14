-- ==========================
-- -------- nerdtree --------
-- ==========================

return {
    'preservim/nerdtree',
    requires = { 'Xuyuanp/nerdtree-git-plugin', opt = true },
    cmd = { 'NERDTreeToggle', 'NERDTreeVCS' },
}
