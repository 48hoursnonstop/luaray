-- Deliberate empty-axis hang rejection, outside original parity totals.
return {
{shape={3,0,0},indices=1,axis=2,mode="wrap",reason="upstream wrap on empty axis with zero trailing chunk hangs; representative call timed out after entry, individual variant not executed"},
{shape={3,0,0},indices={1,-1},axis=2,mode="wrap",reason="upstream wrap on empty axis with zero trailing chunk hangs; representative call timed out after entry, individual variant not executed"},
{shape={3,0,0},indices={7},axis=2,mode="wrap",reason="upstream wrap on empty axis with zero trailing chunk hangs; representative call timed out after entry, individual variant not executed"}
}
