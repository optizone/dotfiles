return {
  "mrcjkb/rustaceanvim",
  opts = function(_, opts)
    opts.server.default_settings["rust-analyzer"].procMacro.ignored["async-trait"] = nil
  end,
}
