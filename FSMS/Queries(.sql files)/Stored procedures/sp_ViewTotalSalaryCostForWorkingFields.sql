Create Procedure sp_ViewTotalSalaryCostForWorkingFields
As
Begin
  Select iif(derTab.DepartmentNo is NULL, 'Diger Çalýþanlar', iif(derTab.DepartmentNo= 1001, 'Þarküteri Çalýþanlarý',
  iif(derTab.DepartmentNo= 1002, 'Kasap Çalýþanlarý', iif(derTab.DepartmentNo= 1003, 'Manav Çalýþanlarý','')))) "Çalýþtýðý Alan"
  , derTab.ToplamMaaþ "Toplam Maaþ Bedeli (TL)"
  From (Select ds.DepartmentNo, sum(e.Salary) ToplamMaaþ
        From Employee e left outer join DepartmentStaff ds on e.EmployeeNo = ds.EmployeeNo
        Group By ds.DepartmentNo) derTab 
End

exec sp_ViewTotalSalaryCostForWorkingFields