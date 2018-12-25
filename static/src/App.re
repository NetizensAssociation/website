
/* Types */

type actionType =
  | Block
  | Warn
  | Protest

type action = {
  action: actionType,
  reason: string
}

type rule = {
  sites: list(string),
  actions: list(action)
}

type policy = {
  name: string,
  website: string,
  rules: list(rule)
}

/* Encoding and decoding */

module Decode = {
  let actionType = json =>
    Json.Decode.string(json) |> fun
      | "block" => Block
      | "warn" => Warn
      | "protest" => Protest
      | _ => failwith("unknown action type");
  let action = json =>
    Json.Decode.{
      action: json |> field("action", actionType),
      reason: json |> field("reason", string),
    };
  let rule = json =>
    Json.Decode.{
      sites: json |> field("sites", list(string)),
      actions: json |> field("actions", list(action)),
    };
  let policy = json =>
    Json.Decode.{
      name: json |> field("name", string),
      website: json |> field("website", string),
      rules: json |> field("website", list(rule)),
    };
  let policies = Json.Decode.array(policy)
};

/* Endpoints */

let url = "http://localhost:8000/";

let fetchPolicies = () =>
  Js.Promise.(
    Fetch.fetch(url ++ "policy")
    |> then_(Fetch.Response.json)
    |> then_(json =>
         json |> Decode.policies |> (policies => Some(policies) |> resolve)
       )
    |> catch(_err => resolve(None))
  );

fetchPolicies()
  |> Js.Promise.then_(value =>
      { Js.log(value);
        Js.Promise.resolve(value);
      });
