class Order:
    
      def __init__(self, customerName, batterType, cakeShape, quantity, date, userID):
         self.orderID = 1
         self.customerName = customerName
         self.batterType = batterType
         self.cakeShape = cakeShape
         self.quantity = quantity
         self.date = date
         self.userID = userID
         
      def getCustomerName(self, orderID):
         return self.customerName
      
