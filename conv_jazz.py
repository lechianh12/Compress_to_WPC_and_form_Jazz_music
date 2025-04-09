from pydub import AudioSegment
import mido
from mido import MidiFile, MidiTrack, Message
import random
import subprocess
import os

def create_jazz_midi(filename="jazz_output.mid", duration_sec=180):
    mid = MidiFile()
    track = MidiTrack()
    mid.tracks.append(track)

    # Set tempo (120 BPM)
    tempo = 500000
    track.append(mido.MetaMessage('set_tempo', tempo=tempo))

    jazz_notes = [60, 62, 64, 65, 67, 69, 71, 72]  # C major scale

    for _ in range(int(duration_sec / 0.5)):
        note = random.choice(jazz_notes)
        track.append(Message('note_on', note=note, velocity=64, time=0))
        track.append(Message('note_off', note=note, velocity=64, time=240))

    mid.save(filename)
    print(f"✅ MIDI file saved as {filename}")


def convert_midi_to_wav_with_timidity(midi_file, output_wav="midi_output.wav"):
    # Use timidity to convert MIDI to WAV
    try:
        subprocess.run(["timidity", midi_file, "-Ow", "-o", output_wav], check=True)
        print(f"✅ Converted {midi_file} to {output_wav} using timidity")
    except subprocess.CalledProcessError as e:
        print("❌ Failed to convert MIDI to WAV:", e)
        exit(1)


def mix_audio(jazz_wav, voice_file, output_file="final_jazz_mix.wav"):
    jazz = AudioSegment.from_wav(jazz_wav)
    voice = AudioSegment.from_file(voice_file)

    # Match duration
    if len(jazz) > len(voice):
        jazz = jazz[:len(voice)]
    else:
        voice = voice[:len(jazz)]

    # Optional: Adjust volume if needed
    jazz += 6
    voice += 3

    # Mix the two
    mixed = voice.overlay(jazz)
    mixed.export(output_file, format="wav")
    print(f"✅ Mixed audio saved as {output_file}")


# ==== MAIN FLOW ====
create_jazz_midi("jazz_song.mid", duration_sec=240)
convert_midi_to_wav_with_timidity("jazz_song.mid", "jazz.wav")
mix_audio("jazz.wav", "/home/nguyen-trong-nghia/Downloads/warped-linear-prediction-master/new.wav")
