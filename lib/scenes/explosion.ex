defmodule ReproEmptyDraw.Scene.Explosion do
  use Scenic.Scene
  import Scenic.Primitives
  alias Scenic.Graph

  @initial_graph Graph.build()

  def init(_, opts) do
    size = 30
    graph =
      @initial_graph
      # Works
      # |> circle(size, t: {100, 100}, id: :circle, stroke: {3, :white}, fill: :white)
      # Broken
      |> circle(size, t: {100, 100}, id: :circle, stroke: {3, :white})
      |> push_graph()
      # |> IO.inspect(label: "graph")

    state = %{graph: graph, size: size, time: 0, viewport: opts[:viewport]}

    # Works
    # Process.send_after(self(), :animate, 100)
    # Broken
    # Process.send_after(self(), {:animate, :blue}, 1)
    Process.send_after(self(), {:animate, :yellow}, 1)
    # Process.send_after(self(), {:animate, :purple}, 60)
    # Process.send_after(self(), {:animate, :red}, 2000)
    # Process.send_after(self(), {:animate, :green}, 3000)

    {:ok, state}
  end

  def handle_info({:animate, stroke_color}, state) do
    require Logger
    Logger.warn "Animating #{stroke_color}\n\n"
    %{graph: graph, size: size} = state

    graph =
      @initial_graph
      # |> Graph.modify(:circle, & circle(&1, size, stroke: {3, stroke_color}, fill: stroke_color))
      # |> Graph.modify(:circle, & circle(&1, size, stroke: {3, stroke_color}, fill: :clear))
      # |> circle(size, t: {100, 100}, id: :circle, stroke: {3, stroke_color}, fill: stroke_color)
      |> circle(size, t: {100, 100}, id: :circle, stroke: {3, stroke_color}, fill: :clear)
      |> push_graph()

    Process.send_after(self(), {:animate, :yellow}, 10)

    {:noreply, state}
  end

  def handle_call(:reload_current_scene, _, _state), do: restart()

  defp restart, do: Process.exit(self(), :kill)
end
