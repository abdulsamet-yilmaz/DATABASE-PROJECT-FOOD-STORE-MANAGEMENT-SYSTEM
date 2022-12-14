Create Procedure sp_ViewTotalSalaryCostForWorkingFields
As
Begin
  Select iif(derTab.DepartmentNo is NULL, 'Diger Çalışanlar', iif(derTab.DepartmentNo= 1001, 'Şarküteri Çalışanları',
  iif(derTab.DepartmentNo= 1002, 'Kasap Çalışanları', iif(derTab.DepartmentNo= 1003, 'Manav Çalışanları','')))) "Çalıştığı Alan"
  , derTab.ToplamMaaş "Toplam Maaş Bedeli (TL)"
  From (Select ds.DepartmentNo, sum(e.Salary) ToplamMaaş
        From Employee e left outer join DepartmentStaff ds on e.EmployeeNo = ds.EmployeeNo
        Group By ds.DepartmentNo) derTab 
End

exec sp_ViewTotalSalaryCostForWorkingFields