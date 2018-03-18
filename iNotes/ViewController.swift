//
//  ViewController.swift
//  iNotes
//
//  Created by Mahnoor Fatima on 23/02/2018.
//  Copyright © 2018 Mahnoor Fatima. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet var notesTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // conform delegate
        notesTV.delegate = self
        notesTV.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromDB()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Segue_2
        let controller:NewNoteVC = segue.destination as! NewNoteVC
        controller.index = sender as? Int ?? -1
        
    }
    
    @IBAction func addNoteAction(_ sender: Any) {
        //Segue_1
        self.performSegue(withIdentifier: "makeNoteSegue", sender: nil)
    }
    
    func getDataFromDB() {
        let tmpArr:[[String:Any]] = UserDefaults.standard.value(forKey: "iNotesDB") as? [[String:Any]] ?? []
        
        notesArr.removeAll()
        for elem in tmpArr {
            let newNote = NoteModel(data: elem)
            notesArr.append(newNote)
        }
        notesTV.reloadData()
    }
    
    func saveDataInDB() {
        // 1. convert array to hashmap array
        // 2. save data in user defaults
        
        var dictArr:[[String:Any]] = []
        for elem in notesArr { //adds notesArr element in elem var on sucessive iterations
            dictArr.append(elem.getDict()) //new element is added to dict_array
        }
        
        UserDefaults.standard.set(dictArr, forKey: "iNotesDB")
    }
    
    //destructor for checking memory leak
    deinit {
        print("ViewController deinit")
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        cell.textLabel?.text = notesArr[indexPath.row].Title
        cell.detailTextLabel?.text = notesArr[indexPath.row].Description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notesArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveDataInDB()
        }
    }
    
    //called when user selects a row in table view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index:Int = indexPath.row
        self.performSegue(withIdentifier: "makeNoteSegue", sender: index)
        
    }
    
    
}
