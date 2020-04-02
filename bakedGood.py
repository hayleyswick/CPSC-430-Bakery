
class BakedGood:
    
    def __init__(self, name, flavor, batterType):
        self.id = 1
        self.name = name
        self.batches = 0
        self.batterPerBatch = 0.0
        self.batterType = batterType
        
        
    def getName(self, bakedGoodID):
        return self.name
    
    def getBatterType(self, bakedGoodID):
        return self.batterType
        
    def calculateBatches(self, bakedGoodID):
        batterQuantity = Inventory.getBatterQuantity(self.batterType)
        self.batches = batterQuantity/batterPerBatch
        return self.batches
        
    
    def calculateBatter(self, bakedGoodID, batches):
        bQuant = batches * batterPerBatch
        return bQuant
        
    def modifyFormula(self, bakedGoodID, batterPerBatch):
        #TODO: modify formula in database with ID equal to bakedGoodID
        self.batterPerBatch = batterPerBatch
        
    def selectExtraBatterGood(self, bakedGoodID):
        #TODO figure out what this method does
        print()
    
    #probably for user interface
    #def displayBatches(self, bakedGOodID):
