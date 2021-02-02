defmodule QueroApi.Repo.Migrations.CreateCampus do
  @moduledoc """
  Migration to create campus table
  """
  use Ecto.Migration

  def change do
    create table(:campus) do
      add :university_id, :integer
      add :name, :string
      add :city, :string

      timestamps()
    end

  end
end
