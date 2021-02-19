------------------------------ MODULE IBCTests --------------------------------

EXTENDS IBC

ICS02CreateOKTest ==
    /\ actionOutcome = "ICS02CreateOK"

ICS02UpdateOKTest ==
    /\ actionOutcome = "ICS02UpdateOK"

ICS02ClientNotFoundTest ==
    /\ actionOutcome = "ICS02ClientNotFound"

ICS02HeaderVerificationFailureTest ==
    /\ actionOutcome = "ICS02HeaderVerificationFailure"

ICS03ConnectionOpenInitOKTest ==
    /\ actionOutcome = "ICS03ConnectionOpenInitOK"

ICS03MissingClientTest ==
    /\ actionOutcome = "ICS03MissingClient"

ICS03ConnectionOpenTryOKTest ==
    /\ actionOutcome = "ICS03ConnectionOpenTryOK"

ICS03InvalidConsensusHeightTest ==
    /\ actionOutcome = "ICS03InvalidConsensusHeight"

ICS03ConnectionNotFoundTest ==
    /\ actionOutcome = "ICS03ConnectionNotFound"

ICS03ConnectionMismatchTest ==
    /\ actionOutcome = "ICS03ConnectionMismatch"

ICS03InvalidProofTest ==
    /\ actionOutcome = "ICS03InvalidProof"

\* ICS02CreateClient tests
ICS02CreateOKTestNeg == ~ICS02CreateOKTest

\* ICS02UpdateClient tests
ICS02UpdateOKTestNeg == ~ICS02UpdateOKTest
ICS02ClientNotFoundTestNeg == ~ICS02ClientNotFoundTest
ICS02HeaderVerificationFailureTestNeg == ~ICS02HeaderVerificationFailureTest

\* ICS03ConnectionOpenInit tests
ICS03ConnectionOpenInitOKTestNeg == ~ICS03ConnectionOpenInitOKTest
ICS03MissingClientTestNeg == ~ICS03MissingClientTest

\* ICS03ConnectionOpenTry tests
ICS03ConnectionOpenTryOKTestNeg == ~ICS03ConnectionOpenTryOKTest
ICS03InvalidConsensusHeightTestNeg == ~ICS03InvalidConsensusHeightTest
ICS03ConnectionNotFoundTestNeg == ~ICS03ConnectionNotFoundTest
ICS03ConnectionMismatchTestNeg == ~ICS03ConnectionMismatchTest
ICS03InvalidProofTestNeg == ~ICS03InvalidProofTest

===============================================================================
