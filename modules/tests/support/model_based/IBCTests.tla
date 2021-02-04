------------------------------ MODULE IBCTests --------------------------------

EXTENDS IBC

ICS02CreateOK ==
    /\ actionOutcome = "ICS02CreateOK"

ICS02UpdateOK ==
    /\ actionOutcome = "ICS02UpdateOK"

ICS02ClientNotFound ==
    /\ actionOutcome = "ICS02ClientNotFound"

ICS02HeaderVerificationFailure ==
    /\ actionOutcome = "ICS02HeaderVerificationFailure"

ICS03ConnectionOpenInitOK ==
    /\ actionOutcome = "ICS03ConnectionOpenInitOK"

ICS03MissingClient ==
    /\ actionOutcome = "ICS03MissingClient"

ICS03ConnectionOpenTryOK ==
    /\ actionOutcome = "ICS03ConnectionOpenTryOK"

ICS03InvalidConsensusHeight ==
    /\ actionOutcome = "ICS03InvalidConsensusHeight"

ICS02CreateOKTest == ~ICS02CreateOK
ICS02UpdateOKTest == ~ICS02UpdateOK
ICS02ClientNotFoundTest == ~ICS02ClientNotFound
ICS02HeaderVerificationFailureTest == ~ICS02HeaderVerificationFailure
ICS03ConnectionOpenInitOKTest == ~ICS03ConnectionOpenInitOK
ICS03MissingClientTest == ~ICS03MissingClient
ICS03ConnectionOpenTryOKTest == ~ICS03ConnectionOpenTryOK
ICS03InvalidConsensusHeightTest == ~ICS03InvalidConsensusHeight

===============================================================================