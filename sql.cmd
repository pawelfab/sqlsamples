DECLARE @StartDate DATETIME
DECLARE @EndDate DATETIME
DECLARE @WorkingDays int
DECLARE @DayTillToday int
SET @StartDate = (SELECT DATEADD(month, DATEDIFF(month, 0, GETDATE()), 0))
SET @EndDate = (SELECT DATEADD(month, ((YEAR(GETDATE()) - 1900) * 12) + MONTH(GETDATE()), -1))


set @WorkingDays = (SELECT
   (DATEDIFF(dd, @StartDate, @EndDate) + 1)
  -(DATEDIFF(wk, @StartDate, @EndDate) * 2)
  -(CASE WHEN DATENAME(dw, @StartDate) = 'Sunday' THEN 1 ELSE 0 END)
  -(CASE WHEN DATENAME(dw, @EndDate) = 'Saturday' THEN 1 ELSE 0 END)+2)
  
 set @DayTillToday = (SELECT
	(DATEDIFF(dd, @StartDate, GETDATE()) + 1)
  -(DATEDIFF(wk, @StartDate, GETDATE()) * 2)
  -(CASE WHEN DATENAME(dw, @StartDate) = 'Sunday' THEN 1 ELSE 0 END)
  -(CASE WHEN DATENAME(dw, GETDATE()) = 'Saturday' THEN 1 ELSE 0 END)+2)
  
select (select SUM(Dok.Razem)from Dok where TypDok=21 and Month(data) = Month(CAST(GETDATE() AS date)) and YEAR(data) = YEAR(CAST(GETDATE() AS date)) and MagId=1)/@DayTillToday * @WorkingDays as estymacja
