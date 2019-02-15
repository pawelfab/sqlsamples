select 
MONTH(Dok.Data) as miesiac,YEAR(Dok.Data) as rok,SUM(Dok.Razem) as Razem, Magazyn.Nazwa as Magazyn, count(Dok.NrDok) as iloscParagon, 
(SUM(Dok.Razem)/count(Dok.NrDok)) as SredParagonu
from 
Dok INNER JOIN Magazyn ON Dok.MagId=Magazyn.MagId 
where 
TypDok=21 
GROUP BY 
YEAR(Dok.Data),MONTH(Dok.Data), Magazyn.Nazwa order by YEAR(Dok.Data) 
desc
