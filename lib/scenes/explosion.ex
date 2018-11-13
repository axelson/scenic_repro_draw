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
      |> circle(size, t: {100, 100}, id: :circle, stroke: {3, :white}, fill: :clear)
      |> push_graph()
      |> IO.inspect(label: "graph")

    state = %{graph: graph, size: size, time: 0, viewport: opts[:viewport]}

    # Works
    # Process.send_after(self(), :animate, 100)
    # Broken
    Process.send_after(self(), :animate, 1)

    {:ok, state}
  end

  def handle_info(:animate, state) do
    %{graph: graph, size: size} = state

    graph =
      graph
      |> Graph.modify(:circle, & circle(&1, size))
      |> push_graph()

    {:noreply, state}
  end

  def handle_call(:reload_current_scene, _, _state), do: restart()

  defp restart, do: Process.exit(self(), :kill)
end
