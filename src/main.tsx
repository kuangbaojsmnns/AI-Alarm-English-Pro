import React, { useState } from 'react'
import { createRoot } from 'react-dom/client'
import './style.css'

function App() {
  const [alarmOn, setAlarmOn] = useState(true)
  const [started, setStarted] = useState(false)
  const [revealed, setRevealed] = useState(false)

  return (
    <main className="shell">
      <nav className="topbar">
        <a className="brand" href="#"><span className="brand-mark">a</span> daybreak<span className="brand-dot">.</span></a>
        <div className="nav-right"><span className="streak">✦ &nbsp; 7 day streak</span><button className="avatar" aria-label="Profile">J</button></div>
      </nav>

      <section className="hero">
        <div className="eyebrow"><span className="live-dot" /> YOUR MORNING, REIMAGINED</div>
        <h1>Good morning,<br /><em>Jamie.</em></h1>
        <p className="intro">A little English, before the day begins.</p>
        <div className="clock">07<span>:</span>00 <span className="ampm">AM</span></div>
        <div className="date">MONDAY, OCTOBER 27</div>
      </section>

      <section className="lesson-card">
        <div className="card-head">
          <div><div className="eyebrow small">TODAY'S WAKE-UP</div><h2>One phrase. A brighter start.</h2></div>
          <span className="level">A2 · EVERYDAY ENGLISH</span>
        </div>
        <div className="phrase-block">
          <div className="sound-icon">♫</div>
          <div className="phrase-copy">
            <div className="phrase">{revealed ? 'The early bird catches the worm.' : 'Tap to reveal your phrase'}</div>
            <div className="translation">{revealed ? '早起的鸟儿有虫吃。' : 'A fresh phrase is waiting for you'}</div>
          </div>
          <button className="play" onClick={() => setRevealed(true)} aria-label="Hear phrase">▶</button>
        </div>
        <div className="lesson-meta"><span>✦ &nbsp; AI-picked for your level</span><span>01 <i>/</i> 03</span></div>
        <div className="progress"><span /></div>
        <div className="actions">
          <button className="primary" onClick={() => { setStarted(!started); setRevealed(true) }}>{started ? 'Lesson started ✓' : 'Start my morning lesson'} <span>↗</span></button>
          <button className="text-button" onClick={() => setRevealed(!revealed)}>{revealed ? 'Hide translation' : 'Reveal phrase'}</button>
        </div>
      </section>

      <section className="bottom-row">
        <div className="alarm-card">
          <div className="section-label">NEXT ALARM</div>
          <div className="alarm-line"><span className="alarm-time">07:00</span><button className={alarmOn ? 'toggle on' : 'toggle'} onClick={() => setAlarmOn(!alarmOn)} aria-label="Toggle alarm"><span /></button></div>
          <div className="alarm-days">WEEKDAYS <span>·</span> Gentle piano</div>
        </div>
        <div className="quote-card">
          <div className="quote-mark">“</div>
          <p>Small steps every morning<br />lead to big things.</p>
          <span>YOUR DAILY REMINDER</span>
        </div>
      </section>
      <footer><span>MAKE MORNINGS MEAN MORE.</span><span>BUILT FOR YOUR NEXT CHAPTER&nbsp; ✳</span></footer>
    </main>
  )
}

createRoot(document.getElementById('root')!).render(<React.StrictMode><App /></React.StrictMode>)
