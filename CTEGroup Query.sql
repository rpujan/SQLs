Declare @tvMatches Table (
	MatchID		int IDENTITY(1,1)
	,MatchDate	datetime
	,HomeTeamID	int
	,AwayTeamID	int
)
Declare @tvGoals Table (
	GoalID		int IDENTITY(1,1)
	,MatchID	int
	,PlayerID	int
	,TeamID		int
)
Declare @tvPlayers Table (
	PlayerID	int IDENTITY(1,1)
	,TeamID		int
	,PlayerName	varchar(30)
)
Declare @tvTeams Table (
	TeamID		int IDENTITY(1,1)
	,TeamName	varchar(20)
)

Insert @tvTeams
Select 'Winners'
Union All
Select 'Losers'
Union All
Select 'Friars'
Union All
Select 'Planes'

Insert @tvPlayers
Select 1, 'Bill'
Union All
Select 1, 'Jim'
Union All
Select 1, 'Ken'
Union All
Select 2, 'James'
Union All
Select 2, 'Smithy'
Union All
Select 2, 'Flip'
Union All
Select 3, 'Dave'
Union All
Select 3, 'Alan'
Union All
Select 3, 'Ethan'
Union All
Select 4, 'Naomi'
Union All
Select 4, 'Erland'
Union All
Select 4, 'Alejandro'

Insert @tvMatches
Select '20120101', 1, 2
Union All
Select '20120201', 3, 4
Union All
Select '20120301', 4, 1

--Winners beat Losers 3-2
--Planes beat Friars 4-2
--Winners beat Planes 2-1
Insert @tvGoals --Match, Player, Team
Select 1, 1, 1
Union All
Select 1, 3, 1
Union All
Select 1, 5, 2
Union All
Select 1, 6, 2
Union All
Select 1, 2, 1
Union All
Select 2, 7, 3
Union All
Select 2, 8, 3
Union All
Select 2, 10, 4
Union All
Select 2, 11, 4
Union All
Select 2, 12, 4
Union All
Select 2, 11, 4
Union All
Select 3, 1, 1
Union All
Select 3, 3, 1
Union All
Select 3, 11, 4



;with cteMatches as
(
	Select	m.MatchID
			,m.MatchDate
			,m.HomeTeamID
			,ht.TeamName HomeTeamName
			,m.AwayTeamID
			,at.TeamName AwayTeamName
			,(	Select	Count(1)
				From	@tvGoals g
				Where	g.MatchID = m.MatchID
				And		g.TeamID = m.HomeTeamID
			) HomeScore
			,(	Select	Count(1)
				From	@tvGoals g
				Where	g.MatchID = m.MatchID
				And		g.TeamID = m.AwayTeamID
			) AwayScore
	From	@tvMatches m
	join	@tvTeams ht
		on	m.HomeTeamID = ht.TeamID
	join	@tvTeams at
		on	m.AwayTeamID = at.TeamID
)	--select * from cteMatches
,cteWinners as
(
	Select	cm.MatchID
			,cm.HomeTeamID
			,cm.HomeTeamName
			,cm.AwayTeamID
			,cm.AwayTeamName
			,Case
				When cm.HomeScore > cm.AwayScore Then cm.HomeTeamID
				When cm.HomeScore < cm.AwayScore Then cm.AwayTeamID
				Else 0
			End WinningTeamID
			,Case
				When cm.HomeScore > cm.AwayScore Then cm.AwayTeamID
				When cm.HomeScore < cm.AwayScore Then cm.HomeTeamID
				Else 0
			End LosingTeamID
			,Case
				When cm.HomeScore = cm.AwayScore Then cm.HomeTeamID
				Else 0
			End DrawHomeTeamID
			,Case
				When cm.HomeScore = cm.AwayScore Then cm.AwayTeamID
				Else 0
			End DrawAwayTeamID
	From	cteMatches cm
)	--select * from ctewinners
,cteRecords as
(
	Select	t.TeamName
			,Count(	Case
						When cw.WinningTeamID = t.TeamID Then 1
					End
					) Wins
			,Count(	Case
						When cw.LosingTeamID = t.TeamID Then 1
					End
					) Losses
			,Count(	Case
						When cw.DrawHomeTeamID = t.TeamID Then 1
						When cw.DrawAwayTeamID = t.TeamID Then 1
					End
					) Draws
	From	@tvTeams t
	join	cteWinners cw
		on	t.TeamID = cw.HomeTeamID
		or	t.TeamID = cw.AwayTeamID
	Group By t.TeamName
)	--select * from cterecords
Select	TeamName
		,Wins
		,Losses
		,Draws
		,((Wins * 3) + Draws) Points
From	cteRecords