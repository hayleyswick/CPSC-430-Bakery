class Inventory:
    
    #batterQuantity = {"chocolate": 35.0, "yellow": 42.0}
    #bakedGoods = 
    
    def __init__(self):
        self.batterQuantity = dict()
        #self.bQuantity = 0.0
        #self.bType = 0
        #holds BakedGood objects
        #maybe baked good list should be a dictionary
        #like 'donuts': 35
        #self.bakedGoods = list()
        self.bakedGoods = dict()
        

    def updateBatterQuantity(self, flavor, quantity):
        self.batterQuantity[flavor] = quantity 
        
    def updateBakedGoods(self, good, quantity):
        self.bakedGoods[good] = quantity
        
