Create Procedure sp_ViewTotalSalaryCostForWorkingFields
As
Begin
  Select iif(derTab.DepartmentNo is NULL, 'Diger �al��anlar', iif(derTab.DepartmentNo= 1001, '�ark�teri �al��anlar�',
  iif(derTab.DepartmentNo= 1002, 'Kasap �al��anlar�', iif(derTab.DepartmentNo= 1003, 'Manav �al��anlar�','')))) "�al��t��� Alan"
  , derTab.ToplamMaa� "Toplam Maa� Bedeli (TL)"
  From (Select ds.DepartmentNo, sum(e.Salary) ToplamMaa�
        From Employee e left outer join DepartmentStaff ds on e.EmployeeNo = ds.EmployeeNo
        Group By ds.DepartmentNo) derTab 
End

exec sp_ViewTotalSalaryCostForWorkingFields