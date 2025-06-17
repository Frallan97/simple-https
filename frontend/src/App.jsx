import { useState, useEffect } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'

function App() {
  const [count, setCount] = useState(0)
  const [apiResponse, setApiResponse] = useState('')
  const [backendHealth, setBackendHealth] = useState('')

  const testPing = async () => {
    try {
      const response = await fetch('/api/ping')
      const data = await response.json()
      setApiResponse(data.message)
    } catch (error) {
      setApiResponse('Error connecting to backend')
    }
  }

  const checkHealth = async () => {
    try {
      const response = await fetch('/api/health')
      const data = await response.json()
      setBackendHealth(data.message)
    } catch (error) {
      setBackendHealth('Backend unhealthy')
    }
  }

  useEffect(() => {
    checkHealth()
  }, [])

  return (
    <>
      <div>
        <a href="https://vite.dev" target="_blank">
          <img src={viteLogo} className="logo" alt="Vite logo" />
        </a>
        <a href="https://react.dev" target="_blank">
          <img src={reactLogo} className="logo react" alt="React logo" />
        </a>
      </div>
      <h1>Simple HTTPS App</h1>
      <div className="card">
        <button onClick={() => setCount((count) => count + 1)}>
          count is {count}
        </button>
        <div style={{ margin: '20px 0' }}>
          <button onClick={testPing} style={{ marginRight: '10px' }}>
            Test Backend Ping
          </button>
          <button onClick={checkHealth}>
            Check Backend Health
          </button>
        </div>
        <p>Backend Health: {backendHealth}</p>
        <p>API Response: {apiResponse}</p>
      </div>
      <p className="read-the-docs">
        This app demonstrates a React frontend with a Go backend deployed with HTTPS.
      </p>
    </>
  )
}

export default App
