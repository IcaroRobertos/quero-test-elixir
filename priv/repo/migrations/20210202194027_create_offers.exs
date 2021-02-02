defmodule QueroApi.Repo.Migrations.CreateOffers do
  @moduledoc """
  Migration to create offers table
  """
  use Ecto.Migration

  def change do
    create table(:offers) do
      add :course_id, :integer
      add :full_price, :float
      add :price_with_discount, :float
      add :discount_percentage, :float
      add :start_date, :string
      add :enrollment_semester, :string
      add :enabled, :boolean

      timestamps()
    end

  end
end
