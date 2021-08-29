defmodule FindMyPersonalWeb.Api.MemberControllerTest do
  use FindMyPersonalWeb.ConnCase

  alias FindMyPersonal.Members
  alias FindMyPersonal.Members.Member

  @create_attrs %{
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

  def fixture(:member) do
    {:ok, member} = Members.create_member(@create_attrs)
    member
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all members", %{conn: conn} do
      conn = get(conn, Routes.api_member_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create member" do
    test "renders member when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_member_path(conn, :create), member: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_member_path(conn, :show, id))

      assert %{
               "id" => id,
               "birth_date" => "2010-04-17",
               "blood" => "some blood",
               "email" => "some email",
               "height" => "some height",
               "name" => "some name",
               "width" => "some width"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_member_path(conn, :create), member: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update member" do
    setup [:create_member]

    test "renders member when data is valid", %{conn: conn, member: %Member{id: id} = member} do
      conn = put(conn, Routes.api_member_path(conn, :update, member), member: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_member_path(conn, :show, id))

      assert %{
               "id" => id,
               "birth_date" => "2011-05-18",
               "blood" => "some updated blood",
               "email" => "some updated email",
               "height" => "some updated height",
               "name" => "some updated name",
               "width" => "some updated width"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, member: member} do
      conn = put(conn, Routes.api_member_path(conn, :update, member), member: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete member" do
    setup [:create_member]

    test "deletes chosen member", %{conn: conn, member: member} do
      conn = delete(conn, Routes.api_member_path(conn, :delete, member))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_member_path(conn, :show, member))
      end
    end
  end

  defp create_member(_) do
    member = fixture(:member)
    %{member: member}
  end
end
