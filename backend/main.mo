import Bool "mo:base/Bool";

import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";
import List "mo:base/List";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
import Text "mo:base/Text";

actor ShoppingList {
  // Define the structure for a shopping list item
  public type Item = {
    id: Nat;
    description: Text;
    completed: Bool;
  };

  // Use a stable variable to store the shopping list items
  stable var items: List.List<Item> = List.nil();
  stable var nextId: Nat = 0;

  // Add a new item to the shopping list
  public func addItem(description: Text) : async Nat {
    let id = nextId;
    nextId += 1;
    let newItem: Item = {
      id;
      description;
      completed = false;
    };
    items := List.push(newItem, items);
    id
  };

  // Toggle the completion status of an item
  public func toggleItem(id: Nat) : async Bool {
    items := List.map(items, func (item: Item) : Item {
      if (item.id == id) {
        return {
          id = item.id;
          description = item.description;
          completed = not item.completed;
        };
      };
      item
    });
    true
  };

  // Delete an item from the shopping list
  public func deleteItem(id: Nat) : async Bool {
    items := List.filter(items, func (item: Item) : Bool {
      item.id != id
    });
    true
  };

  // Get all items in the shopping list
  public query func getItems() : async [Item] {
    List.toArray(items)
  };
}
