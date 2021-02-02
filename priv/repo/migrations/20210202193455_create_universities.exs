defmodule QueroApi.Repo.Migrations.CreateUniversities do
  @moduledoc """
  Migration to create universities table
  """
  use Ecto.Migration

  def change do
    create table(:universities) do
      add :name, :string
      add :score, :float
      add :logo_url, :string

      timestamps()
    end

  end
end
