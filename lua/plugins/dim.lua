local function a(yes)
end

return {
  'zbirenbaum/neodim',
  event = 'LspAttach',
  config = function()
    require('neodim').setup {
      alpha = 0.50,
      blend_color = '#000000',
      update_in_insert = {
        enable = false,
        delay = 100
      },
      --[[hide = {
        virtual_text = true,
        signs = true,
        underline = true
      }]]
    }
  end
}
