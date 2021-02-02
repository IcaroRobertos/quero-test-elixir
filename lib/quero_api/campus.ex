defmodule QueroApi.Campus do
  @moduledoc """
  Campus schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "campus" do
    field :university_id, :integer
    field :city, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(campus, attrs) do
    campus
    |> cast(attrs, [:university_id, :name, :city])
    |> validate_required([:university_id, :name, :city])
  end
end
