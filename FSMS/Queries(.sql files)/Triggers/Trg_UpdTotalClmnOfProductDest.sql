Create Trigger Trg_UpdTotalClmnOfProductDest
  on ProductDestruction
  after insert
As
Begin
  Declare @Quantity decimal(9,3)
  Set @Quantity = (Select i.Quantity From inserted i)

--Update TotalCost of recent destruction
  Update pd
  Set pd.TotalCost = (pd.UnitDestructionCost * pd.Quantity)
  From ProductDestruction pd
  Where pd.DestructionNo = (Select i.DestructionNo From inserted i)

--Update StockAmount of desructed product
  Update p
  Set p.StockAmount = (p.StockAmount - @Quantity)
  From Product p
  Where p.Barcode = (Select i.Barcode From inserted i)
End