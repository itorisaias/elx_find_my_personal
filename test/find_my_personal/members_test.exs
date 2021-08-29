defmodule FindMyPersonal.MembersTest do
  use FindMyPersonal.DataCase

  alias FindMyPersonal.Members

  describe "members" do
    alias FindMyPersonal.Members.Member

    @valid_attrs %{
      birth_date: ~D[2010-04-17],
      blood: "some blood",
      email: "some email",
      height: "some height",
      name: "some name",
      width: "some width"
    }
    @update_attrs %{
      birth_date: ~D[2011-05-18],
      blood: "some updated blood",
      email: "some updated email",
      height: "some updated height",
      name: "some updated name",
      width: "some updated width"
    }
    @invalid_attrs %{birth_date: nil, blood: nil, email: nil, height: nil, name: nil, width: nil}

    def member_fixture(attrs \\ %{}) do
      {:ok, member} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Members.create_member()

      member
    end

    test "list_members/0 returns all members" do
      member = member_fixture()
      assert Members.list_members() == [member]
    end

    test "get_member!/1 returns the member with given id" do
      member = member_fixture()
      assert Members.get_member!(member.id) == member
    end

    test "create_member/1 with valid data creates a member" do
      assert {:ok, %Member{} = member} = Members.create_member(@valid_attrs)
      assert member.birth_date == ~D[2010-04-17]
      assert member.blood == "some blood"
      assert member.email == "some email"
      assert member.height == "some height"
      assert member.name == "some name"
      assert member.width == "some width"
    end

    test "create_member/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Members.create_member(@invalid_attrs)
    end

    test "update_member/2 with valid data updates the member" do
      member = member_fixture()
      assert {:ok, %Member{} = member} = Members.update_member(member, @update_attrs)
      assert member.birth_date == ~D[2011-05-18]
      assert member.blood == "some updated blood"
      assert member.email == "some updated email"
      assert member.height == "some updated height"
      assert member.name == "some updated name"
      assert member.width == "some updated width"
    end

    test "update_member/2 with invalid data returns error changeset" do
      member = member_fixture()
      assert {:error, %Ecto.Changeset{}} = Members.update_member(member, @invalid_attrs)
      assert member == Members.get_member!(member.id)
    end

    test "delete_member/1 deletes the member" do
      member = member_fixture()
      assert {:ok, %Member{}} = Members.delete_member(member)
      assert_raise Ecto.NoResultsError, fn -> Members.get_member!(member.id) end
    end

    test "change_member/1 returns a member changeset" do
      member = member_fixture()
      assert %Ecto.Changeset{} = Members.change_member(member)
    end
  end
end
