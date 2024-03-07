function setup(lspconfig)
  lspconfig.pyright.setup {
    capabilities = capabilities
  }
end

function getLSPName()
  return "pyright"
end
