Create Procedure sp_ViewTotalSalaryCostOfEmployees
As
Begin 
  Select SUM(e.Salary) "Toplam �al��an Gideri (TL)"
  From Employee e  
End

Exec sp_ViewTotalSalaryCostOfEmployees