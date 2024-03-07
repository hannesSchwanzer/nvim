function setup(lspconfig)
lspconfig.tsserver.setup({
    settings = {},
    on_attach = on_attach,
    capabilities = capabilities
})
end

function getLSPName()
  return "tsserver"
end
