import * as React from "react"
import Row from "components/row"

const Venue = (props) => {
  const rowNumbers = Array.from(Array(props.seatsPerRow).keys())
  const rowItems = rowNumbers.map((rowNumber) => {
    return (
      <Row
        key={rowNumber}
        rowNumber={rowNumber}
        seatsPerRow={props.seatsPerRow}
      />
    )
  })
  return (
    <table className="table">
      <tbody>{rowItems}</tbody>
    </table>
  )
}

export default Venue
