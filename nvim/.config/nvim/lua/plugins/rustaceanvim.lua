return {
  "mrcjkb/rustaceanvim",
  opts = function(_, opts)
    local ra = opts.server.default_settings["rust-analyzer"]
    ra.procMacro.ignored["async-trait"] = nil
    ra.rustfmt = { extraArgs = { "+nightly" } }
  end,
}
