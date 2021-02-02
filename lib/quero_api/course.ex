defmodule QueroApi.Course do
  @moduledoc """
  Course schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "courses" do
    field :campus_id, :integer
    field :kind, :string
    field :level, :string
    field :name, :string
    field :shift, :string

    timestamps()
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [:campus_id, :name, :kind, :level, :shift])
    |> validate_required([:campus_id, :name, :kind, :level, :shift])
  end
end
