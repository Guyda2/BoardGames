SELECT 
    b.BoardGameID,
    b.BoardGameName,
    b.ReleaseYear AS GameReleaseYear,
    b.PrimaryMechanic,
    ps.GameTheme,
    d.CreatorName AS Designer,
    a.CreatorName AS Artist,
    p.CreatorName AS Publisher,
    MAX(ri.ReleaseYear) AS FirstReleaseYear,
    STRING_AGG(e.ExpansionName, ', ') WITHIN GROUP (ORDER BY e.ExpansionName) AS Expansions
FROM BoardGame b
LEFT JOIN PlayStyle ps
    ON b.BoardGameID = ps.BoardGameID
LEFT JOIN Creators d
    ON b.BoardGameID = d.BoardGameID AND d.Role = 'Designer'
LEFT JOIN Creators a
    ON b.BoardGameID = a.BoardGameID AND a.Role = 'Artist'
LEFT JOIN Creators p
    ON b.BoardGameID = p.BoardGameID AND p.Role = 'Publisher'
LEFT JOIN ReleaseInfo ri
    ON b.BoardGameID = ri.BoardGameID
LEFT JOIN Expansion e
    ON b.BoardGameID = e.BoardGameID
GROUP BY 
    b.BoardGameID,
    b.BoardGameName,
    b.ReleaseYear,
    b.PrimaryMechanic,
    ps.GameTheme,
    d.CreatorName,
    a.CreatorName,
    p.CreatorName
ORDER BY b.BoardGameID;
