#Try this
#Update batter quantity
#Questions
#What is the formula?

class Inventory:

    #dummy values for this file
	bQuantYellow = 35.0
    bQuantChocolate = 35.0
    #call database
    #set batter quantities accordingly
	def getBatterQuantity(self, flavor):
	    if flavor == "yellow":
	        return bQuantYellow
	    elif flavor == "chocolate"
	        return bQuantChocolate

class BakedGood:

    name = ""
    flavor = ""
    batches = 0
    
    def __init__(self, name, flavor):
        self.name = name
        self.flavor = flavor
	
    
        
    def calculateBatches(self):
        bQuant = Inventory.getBatterQuantity(self.flavor)
        #TODO: call database for formula based on name
        #formula is a dictionary of variables and values
        #returns amount of batter for a batch
        batter = 5.0
        batches = int(bQuant\batter)
        
	    return batches
        
      


def setExtraBatterGood(self, name, flavor):
        self.name = name
        self.flavor = flavor

def main():

    #get name and flavor from the user
    #connect to front end
    bakedGood = BakedGood(name, flavor)
    batches = bakedGood.calculateBatches()
    print("You can make " + str(batches) " batches\n")

main()

