//
//  NewNoteVC.swift
//  iNotes
//
//
//  Created by Mahnoor Fatima on 01/03/2018.
//  Copyright © 2018 Mahnoor Fatima. All rights reserved.
//

import UIKit

var notesArr:[NoteModel] = []

class NewNoteVC: UIViewController {

    @IBOutlet var titleTF: UITextField!
    @IBOutlet var descriptionTV: UITextView!
    @IBOutlet var saveBtn: UIBarButtonItem!
    
    private var noteObj:NoteModel = NoteModel(data: [:])
    
    var index:Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (index != -1 ){
            //if note is clicked from table view
            //no new note
            titleTF.text = notesArr[index].Title
            descriptionTV.text = notesArr[index].Description
        }
        
        saveBtn.isEnabled = false
        titleTF.delegate = self
        descriptionTV.delegate = self
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
    
    @IBAction func saveAction(_ sender: Any) {

        if (index != -1){
            notesArr[index].Title = titleTF.text!
            notesArr[index].Description = descriptionTV.text!
        }
        else {
            noteObj.Title = titleTF.text!
            noteObj.Description = descriptionTV.text!
            notesArr.append(noteObj)
        }
        saveDataInDB()
        navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("NewNoteVC deinit")
    }
    
}

extension NewNoteVC : UITextViewDelegate, UITextFieldDelegate {
    
    func authNote() {
        if titleTF.text?.isEmpty == true {
            saveBtn.isEnabled = false
        }
        else {
            saveBtn.isEnabled = true
        }
    }
    
    //called when textfield becomes editable
    func textFieldDidBeginEditing(_ textField: UITextField) {
        authNote()
    }
    
    //called when textfield ends editing
    func textFieldDidEndEditing(_ textField: UITextField) {
        authNote()
    }
    
    //called when textview becomes editable
    func textViewDidBeginEditing(_ textView: UITextView) {
        authNote()
    }
    
    //called when textview ends editing
    func textViewDidEndEditing(_ textView: UITextView) {
        authNote()
    }
    
    //called when textview's text changes
    func textViewDidChange(_ textView: UITextView) {
        authNote()
    }
    
    
    
}
