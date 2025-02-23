use std::fmt;

use serde_derive::{Deserialize, Serialize};

use super::error::Error;

/// Type of the client, depending on the specific consensus algorithm.
#[derive(Copy, Clone, Debug, PartialEq, Eq, PartialOrd, Ord, Hash, Serialize, Deserialize)]
pub enum ClientType {
    Tendermint = 1,

    #[cfg(any(test, feature = "mocks"))]
    Mock = 9999,
}

impl ClientType {
    const TENDERMINT_STR: &'static str = "07-tendermint";

    #[cfg_attr(not(test), allow(dead_code))]
    const MOCK_STR: &'static str = "9999-mock";

    /// Yields the identifier of this client type as a string
    pub fn as_str(&self) -> &'static str {
        match self {
            Self::Tendermint => Self::TENDERMINT_STR,

            #[cfg(any(test, feature = "mocks"))]
            Self::Mock => Self::MOCK_STR,
        }
    }
}

impl fmt::Display for ClientType {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "ClientType({})", self.as_str())
    }
}

impl std::str::FromStr for ClientType {
    type Err = Error;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        match s {
            Self::TENDERMINT_STR => Ok(Self::Tendermint),

            #[cfg(any(test, feature = "mocks"))]
            Self::MOCK_STR => Ok(Self::Mock),

            _ => Err(Error::unknown_client_type(s.to_string())),
        }
    }
}

#[cfg(test)]
mod tests {
    use std::str::FromStr;
    use test_env_log::test;

    use super::ClientType;

    #[test]
    fn parse_tendermint_client_type() {
        let client_type = ClientType::from_str("07-tendermint");

        match client_type {
            Ok(ClientType::Tendermint) => (),
            _ => panic!("parse failed"),
        }
    }

    #[test]
    fn parse_mock_client_type() {
        let client_type = ClientType::from_str("9999-mock");

        match client_type {
            Ok(ClientType::Mock) => (),
            _ => panic!("parse failed"),
        }
    }

    #[test]
    fn parse_unknown_client_type() {
        let client_type = ClientType::from_str("some-random-client-type");

        match client_type {
            Err(err) => assert_eq!(
                format!("{}", err),
                "unknown client type: some-random-client-type"
            ),
            _ => panic!("parse didn't fail"),
        }
    }

    #[test]
    fn parse_mock_as_string_result() {
        let client_type = ClientType::Mock;
        let type_string = client_type.as_str();
        let client_type_from_str = ClientType::from_str(type_string).unwrap();
        assert_eq!(client_type_from_str, client_type);
    }

    #[test]
    fn parse_tendermint_as_string_result() {
        let client_type = ClientType::Tendermint;
        let type_string = client_type.as_str();
        let client_type_from_str = ClientType::from_str(type_string).unwrap();
        assert_eq!(client_type_from_str, client_type);
    }
}
