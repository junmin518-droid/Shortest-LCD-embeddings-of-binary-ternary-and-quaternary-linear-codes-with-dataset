INPUT_FILE := "many_shortest_lcd_hamming_representatives.txt";

RepFmt := recformat< rep_id, code >;

function ParseRepId(line)
    pos := Position(line, ":");
    return StringToInteger(Substring(line, pos + 2, #line - pos - 1));
end function;

function ParseFieldSize(signature_line)
    parts := Split(signature_line, ";");
    q_part := parts[1];
    pos := Position(q_part, "q=");
    return StringToInteger(Substring(q_part, pos + 2, #q_part - pos - 1));
end function;

function ParseMatrixRow(line)
    left := Position(line, "[");
    right := Position(line, "]");
    row_str := Substring(line, left + 1, right - left - 1);
    tokens := Split(row_str, " ");
    row := [];
    for token in tokens do
        if token ne "" then
            Append(~row, StringToInteger(token));
        end if;
    end for;
    return row;
end function;

procedure CheckAndStore(~buckets, rep_id, q, signature, rows)
    F := GF(q);
    C := LinearCode(Matrix(F, #rows, #rows[1], rows));
    rep := rec< RepFmt | rep_id := rep_id, code := C >;

    if not IsDefined(buckets, signature) then
        buckets[signature] := [rep];
        return;
    end if;

    bucket := buckets[signature];
    for old in bucket do
        if IsEquivalent(old`code, C) then
            printf "Equivalent representatives found: REP_ID %o and REP_ID %o\n", old`rep_id, rep_id;
            quit;
        end if;
    end for;

    Append(~bucket, rep);
    buckets[signature] := bucket;
end procedure;

print "Checking pairwise inequivalence in", INPUT_FILE;

try
    f := Open(INPUT_FILE, "r");
catch e
    print "Cannot open", INPUT_FILE;
    quit;
end try;

buckets := AssociativeArray();
rep_id := 0;
q := 0;
signature := "";
rows := [];
in_matrix := false;
count := 0;

line := Gets(f);
while not IsEof(line) do
    if in_matrix and (Position(line, "[") ne 1) then
        CheckAndStore(~buckets, rep_id, q, signature, rows);
        count +:= 1;
        rows := [];
        in_matrix := false;
    end if;

    if Position(line, "REP_ID:") eq 1 then
        rep_id := ParseRepId(line);
    elif Position(line, "SIGNATURE:") eq 1 then
        signature := line;
        q := ParseFieldSize(line);
    elif line eq "GENERATOR_MATRIX:" then
        rows := [];
        in_matrix := true;
    elif in_matrix and (Position(line, "[") eq 1) then
        Append(~rows, ParseMatrixRow(line));
    end if;

    line := Gets(f);
end while;

if in_matrix then
    CheckAndStore(~buckets, rep_id, q, signature, rows);
    count +:= 1;
end if;

delete f;
printf "Verified: all %o representatives are pairwise inequivalent.\n", count;
