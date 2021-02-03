defmodule QueroApi.Campus do
  @moduledoc """
  Campus schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "campus" do
    field :city, :string
    field :name, :string

    belongs_to :university, QueroApi.University
    has_many :courses, QueroApi.Course

    timestamps()
  end

  @doc false
  def changeset(campus, attrs) do
    campus
    |> cast(attrs, [:university_id, :name, :city])
    |> validate_required([:university_id, :name, :city])
  end
end
