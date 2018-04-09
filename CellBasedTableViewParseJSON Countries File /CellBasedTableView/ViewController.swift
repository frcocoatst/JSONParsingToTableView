//
//  ViewController.swift
//  CellBasedTableView
//
//  Created by Debasis Das on 5/15/17.
//  Copyright © 2017 Knowstack. All rights reserved.
//
//  Cell based NSTableView using datasource.
import Cocoa

struct Country : Decodable {
    let name : String
    let capital : String
    let region : String
}


class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource  {
    
    @IBOutlet weak var tableView:NSTableView!
    
    var countries = [Country]()
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        // return count
        return self.countries.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        
        
        if (tableColumn?.identifier)!.rawValue == "name" {
            return self.countries[row].name
        }
        else
            if (tableColumn?.identifier)!.rawValue == "capital" {
                return self.countries[row].capital
            }
            else
            {
                return self.countries[row].region
        }

    }
    
    func parseJSON() {

        let path = Bundle.main.path(forResource: "all", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        do {
            let data = try Data(contentsOf: url)
            
            self.countries = try JSONDecoder().decode([Country].self, from: data)
            
            for eachCountry in self.countries {
                print(eachCountry.name + " : " + eachCountry.capital)
            }
        }
        catch {
            print("Error")
        }
        
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self // as? NSTableViewDelegate
        self.tableView.dataSource = self
        
        //
        parseJSON()
        
    }
}


