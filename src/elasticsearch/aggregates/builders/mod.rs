use pgx::JsonB;
use serde_json::Value;
use std::collections::HashMap;

mod adjacency_matrix;
mod auto_date_histogram;
mod childern;
mod date_histogram;
mod filter;
mod filters;
mod histogram;
mod metrics;
mod range;
mod sampler;
mod terms;

pub(crate) fn make_children_map(
    children: Option<Vec<JsonB>>,
) -> HashMap<String, serde_json::Value> {
    let mut map = HashMap::new();

    if let Some(children) = children {
        for child in children {
            match child.0 {
                Value::Object(o) => map.extend(o.into_iter()),
                _ => panic!("invalid children array"),
            }
        }
    }

    map
}
