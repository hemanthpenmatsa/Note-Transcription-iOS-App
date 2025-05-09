# Note Transcription iOS App - Implementation Guide

## 0. Overview

This iOS application is a smart note-taking tool designed to transcribe audio from social media videos shared by users. It allows users to:

* Share videos directly from social platforms.
* Extract and transcribe audio from the videos.
* Save concise, relevant information as notes.
* Organize notes into folders.

The app includes OpenAI (or other LLM) integration to filter out unnecessary audio content like greetings or filler, saving only the core information (e.g., recipes, instructions).

---

## 1. Project File Structure

```
NoteTranscriptionApp/
├── Models/
│   ├── Note.swift
│   ├── Folder.swift
├── Views/
│   ├── NotesListView.swift
│   ├── NoteDetailView.swift
│   ├── FolderListView.swift
│   └── TranscriptionView.swift
├── ViewModels/
│   ├── NotesViewModel.swift
│   ├── FolderViewModel.swift
│   └── TranscriptionViewModel.swift
├── Services/
│   ├── AudioProcessor.swift
│   ├── TranscriptionService.swift
│   ├── OpenAIService.swift
│   └── VideoSharingHandler.swift
├── Utilities/
│   └── DateFormatter.swift
├── Resources/
│   └── Assets.xcassets
├── AppDelegate.swift
├── SceneDelegate.swift
└── ContentView.swift
```

---

## 2. Core Functionalities

### 2.1 Note Management System

#### Files:

* `Note.swift`
* `NotesViewModel.swift`
* `NotesListView.swift`, `NoteDetailView.swift`

#### Responsibilities:

* Create, read, update, delete notes.
* Store note properties: `id`, `title`, `content`, `createdAt`, `updatedAt`, `folderId`.

#### Architecture:

* `Note`: Struct model for each note.
* `NotesViewModel`: Manages note state, persists notes (using `CoreData` or `UserDefaults`, depending on scale).
* `NotesListView`: Displays a list of notes per folder.
* `NoteDetailView`: Shows and edits a single note.

---

### 2.2 Folder Management System

#### Files:

* `Folder.swift`
* `FolderViewModel.swift`
* `FolderListView.swift`

#### Responsibilities:

* Organize notes into folders.
* CRUD support for folders.

#### Architecture:

* `Folder`: Struct for folder model.
* `FolderViewModel`: Handles folder operations and note filtering.
* `FolderListView`: Displays all folders and their contained notes.

---

### 2.3 Audio Processing

#### Files:

* `AudioProcessor.swift`

#### Responsibilities:

* Extract audio from shared video.
* Split audio into chunks for processing.

#### Key Functions:

* `extractAudio(from videoURL: URL) -> URL`
* `splitAudioChunks(audioURL: URL) -> [URL]`

---

### 2.4 Transcription System

#### Files:

* `TranscriptionService.swift`
* `TranscriptionViewModel.swift`
* `TranscriptionView.swift`

#### Responsibilities:

* Convert audio chunks to text.
* Use Apple Speech Framework for transcription.

#### Key Functions:

* `transcribe(audioURL: URL, completion: @escaping (String) -> Void)`
* Displays transcription progress in `TranscriptionView`.

---

### 2.5 LLM Integration (OpenAI Filtering)

#### Files:

* `OpenAIService.swift`

#### Responsibilities:

* Send raw transcription to OpenAI.
* Receive refined text with only relevant content.

#### Key Functions:

* `filterRelevantContent(rawText: String, completion: @escaping (String) -> Void)`
* Integrates via OpenAI API (use `text-davinci-003` or `gpt-4`)
* Prompt example: “Extract only useful instructions from the following transcription. Ignore greetings and irrelevant details.”

---

### 2.6 Sharing and Intake

#### Files:

* `VideoSharingHandler.swift`

#### Responsibilities:

* Receive video shared from Instagram/YouTube/etc.
* Save to temporary local storage.
* Kick off audio processing pipeline.

#### Key Functions:

* `handleSharedVideo(url: URL)`
* Should trigger:

  * `AudioProcessor.extractAudio()`
  * `TranscriptionService.transcribe()`
  * `OpenAIService.filterRelevantContent()`
  * Save final text into `Note`

---

### 2.7 Date Formatting

#### Files:

* `DateFormatter.swift`

#### Responsibilities:

* Show friendly time formats in views.
* Examples: "2m ago", "3h ago", "Yesterday".

#### Key Functions:

* `formatRelativeDate(from: Date) -> String`

---

## 3. Summary Flow

1. User shares a video from social media to the app.
2. `VideoSharingHandler` captures and stores the video.
3. `AudioProcessor` extracts and chunks audio.
4. `TranscriptionService` converts audio to raw text.
5. `OpenAIService` cleans the transcription.
6. `NotesViewModel` saves cleaned text as a new note in a chosen folder.
7. UI updates via SwiftUI views (`NotesListView`, `NoteDetailView`, etc.)

This guide offers a complete architecture to start development clearly and efficiently. Refer to section numbers (e.g., 2.4 for Transcription) when collaborating with teammates.