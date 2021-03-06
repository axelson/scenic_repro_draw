defmodule ReproEmptyDraw.MixProject do
  use Mix.Project

  def project do
    [
      app: :repro_empty_draw,
      version: "0.1.0",
      elixir: "~> 1.7",
      build_embedded: true,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {ReproEmptyDraw, []},
      extra_applications: []
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:scenic, "~> 0.8"},
      {:scenic_driver_glfw, "~> 0.8"},

      # These deps are optional and are included as they are often used.
      # If your app doesn't need them, they are safe to remove.
      {:scenic_sensor, "~> 0.7"},
      {:scenic_clock, ">= 0.0.0"}
    ]
  end
end
