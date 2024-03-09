defmodule PhoenixBoilerplate.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixBoilerplate.Accounts` context.
  """

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> PhoenixBoilerplate.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end

  @doc """
  Generate a role.
  """
  def role_fixture(attrs \\ %{}) do
    {:ok, role} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> PhoenixBoilerplate.Accounts.create_role()

    role
  end

  @doc """
  Generate a user_role.
  """
  def user_role_fixture(attrs \\ %{}) do
    {:ok, user_role} =
      attrs
      |> Enum.into(%{
        role_id: 42,
        user_id: 42
      })
      |> PhoenixBoilerplate.Accounts.create_user_role()

    user_role
  end
end
