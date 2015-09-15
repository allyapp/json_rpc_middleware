describe TestApp do

  describe "JSON-RPC methods" do
    before do
      header "Content-Type", "application/json"
      post "/api", { id: "foo", jsonrpc: "2.0", method: method, params: params }.to_json
    end

    let(:body) { JSON[last_response.body] }

    context "when request is valid" do
      let(:method) { "valid_method" }
      let(:params) { { valid_param: "bar" } }

      it "returns a valid response" do
        expect(body).to eq({"message" => "It works!"})
      end
    end

    context "with invalid params" do
      let(:method) { "valid_method" }
      let(:params) { { foo: "bar" } }

      it "returns error message" do
        expect(body["error"]["message"]).to eq("Invalid params")
      end
    end

    context "with invalid method" do
      let(:method) { "foo" }
      let(:params) { {valid_param: "foo"} }

      it "returns error message" do
        expect(body["error"]["message"]).to eq("Method not found")
      end

      it "returns error core" do
        expect(body["error"]["code"]).to eq(-32_601)
      end
    end
  end
end
